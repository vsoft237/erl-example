#!/usr/bin/env bash

cd ../resource/proto
../../_build/default/lib/gpb/bin/protoc-erl ../proto/all_pb.proto

mv all_pb.erl ../../apps/logic/src/proto/
mv all_pb.hrl ../../apps/logic/include/