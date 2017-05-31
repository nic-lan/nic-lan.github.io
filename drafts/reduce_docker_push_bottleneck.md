# Reduce Docker push bottleneck

how to take advantage of the docker layer structure and remove low internet bandwidth bottleneck

## A short introduction

When learning how to build a docker image one of the things that i have been very excited about is the chance to build an image, layer by layer, and when one layer is successfully built you can just put next levels on top of it. 

But now that i have built the image for my "amazing" service there is this little problem with pushing around 1 Gb trough the very low bandwidth of my home network.

A solution I found is basically saying "if the net is the problem, then avoid the net ;-)'

## Create a base image layer 

First, let set up a Dockerfile for [niclan.io](http://www.niclan.io/) 

```
FROM elixir:1.2

RUN apt-get update -qq

RUN apt-get install -y build-essential jq git-all

RUN apt-get -y install libssl-dev

# to install brunch
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -y nodejs

RUN npm install -g brunch
```

As it is possible to see, the base for this Dockerfile is an already existing elixir image. On top of that some commands to prepare the base env for my phoenix app.

The nice of that is that once this image is succesfully built there won't be any need to rebuild it again and it can just be used as a base layer for the layers to build on top of it. In this way it is possible to reduce the amount of time needed to redeploy the service when some new features have been added, because those features would very likely affect only the layers on top of the base ones, resulting on a spared times around a decades of minutes.

Indeed it is time to set up another Dockerfile that uses this base phoenix image and that cares only about releasing the app 

## Make docker build the image locally 

Now that we have a base image for the our "amazing" service, we can try to reduce the bottleneck of pushing the already built image just by making the machine, where the service is hosted, responsable to fetch the code and to do whatever we want with it.

```
FROM niclan/phoenix-base-no-ecto

RUN git clone https://github.com/nic-lan/nic-lan.github.io.git /app

WORKDIR /app

RUN yes | mix deps.get

RUN brunch build

RUN mix compile

EXPOSE 80

CMD PORT=80 mix phoenix.server
```


All the magic happens here:
```
RUN git clone https://github.com/nic-lan/nic-lan.github.io.git /app
```

The host where the docker image is built is responsable to fetch the code ( a few kBs ) and then to built it locally ( hundreds of GBs ). 

What is the advantage of that ? Easy peasy... consider you are working remotely and you upload bandwith is a bottleneck ( home office, tiny island of the caribbean )... then you will not need hours before beeing able to deploy your docker image.... 


