#!/bin/bash

chartName=${1}

az acr helm show -n hmctspublic $chartName