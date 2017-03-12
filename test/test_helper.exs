Application.ensure_all_started(:hound)

ExUnit.start
Code.require_file("test/hound_support.exs")
