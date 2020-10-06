#!/bin/bash

while [ "$1" != "" ]; do
    case $1 in
      "--project-name")
        shift
        PROJECT_NAME="$1"
        echo
        shift
        ;;
        "--zone")
        shift
        ZONE="$1"
        echo
        shift
        ;;
        "--region")
        shift
        REGION="$1"
        echo
        shift
        ;;
        "--bucket-name")
        shift
        BUCKET_NAME="$1"
        echo
        shift
        ;;
        "--cluster-name")
        shift
        CLUSTER_NAME="$1"
        echo
        shift
        ;;
        "--master-machine-type")
        shift
        MASTER_MACHINE_TYPE="$1"
        echo
        shift
        ;;
        "--worker-machine-type")
        shift
        WORKER_MACHINE_TYPE="$1"
        echo
        shift
        ;;
        "--num-workers")
        shift
        NUM_WORKERS="$1"
        echo
        shift
        ;;
        *)
   esac
done


echo " Set project:"
gcloud config set project ${PROJECT_NAME}

echo "Enable APIs:"

gcloud services enable dataproc.googleapis.com \
compute.googleapis.com \
storage-component.googleapis.com \
bigquery.googleapis.com \
bigquerystorage.googleapis.com

echo "Set Environment Variables:" 

echo "Create Cluster:"
gcloud beta dataproc clusters create ${CLUSTER_NAME}  \
--region=${REGION}   --zone=${ZONE}   --image-version=1.4  --master-machine-type=${MASTER_MACHINE_TYPE} --worker-machine-type=${WORKER_MACHINE_TYPE} --num-workers ${NUM_WORKERS} --bucket=${BUCKET} --optional-components=ANACONDA,JUPYTER --enable-component-gateway --metadata 'PIP_PACKAGES=google-cloud-bigquery google-cloud-storage' --properties "spark:spark.jars=gs://spark-lib/bigquery/spark-bigquery-latest.jar"


