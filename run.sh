#!/bin/bash

mkdir -p results

echo "reclin2"
/usr/bin/time -v Rscript reclin2.R 0.1 &> results/reclin2-0.1.txt
/usr/bin/time -v Rscript reclin2.R 0.2 &> results/reclin2-0.2.txt
/usr/bin/time -v Rscript reclin2.R 0.3 &> results/reclin2-0.3.txt
/usr/bin/time -v Rscript reclin2.R 0.4 &> results/reclin2-0.4.txt
/usr/bin/time -v Rscript reclin2.R 0.5 &> results/reclin2-0.5.txt
/usr/bin/time -v Rscript reclin2.R 0.6 &> results/reclin2-0.6.txt
/usr/bin/time -v Rscript reclin2.R 0.7 &> results/reclin2-0.7.txt
/usr/bin/time -v Rscript reclin2.R 0.8 &> results/reclin2-0.8.txt
/usr/bin/time -v Rscript reclin2.R 0.9 &> results/reclin2-0.9.txt
/usr/bin/time -v Rscript reclin2.R 1.0 &> results/reclin2-1.0.txt

echo "reclin2_cluster"
/usr/bin/time -v Rscript reclin2_cluster.R 0.1 &> results/reclin2_cluster-0.1.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.2 &> results/reclin2_cluster-0.2.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.3 &> results/reclin2_cluster-0.3.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.4 &> results/reclin2_cluster-0.4.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.5 &> results/reclin2_cluster-0.5.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.6 &> results/reclin2_cluster-0.6.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.7 &> results/reclin2_cluster-0.7.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.8 &> results/reclin2_cluster-0.8.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.9 &> results/reclin2_cluster-0.9.txt
/usr/bin/time -v Rscript reclin2_cluster.R 1.0 &> results/reclin2_cluster-1.0.txt

echo "reclin"
/usr/bin/time -v Rscript reclin.R 0.1 &> results/reclin-0.1.txt
/usr/bin/time -v Rscript reclin.R 0.2 &> results/reclin-0.2.txt
/usr/bin/time -v Rscript reclin.R 0.3 &> results/reclin-0.3.txt
/usr/bin/time -v Rscript reclin.R 0.4 &> results/reclin-0.4.txt
/usr/bin/time -v Rscript reclin.R 0.5 &> results/reclin-0.5.txt
/usr/bin/time -v Rscript reclin.R 0.6 &> results/reclin-0.6.txt
/usr/bin/time -v Rscript reclin.R 0.7 &> results/reclin-0.7.txt
/usr/bin/time -v Rscript reclin.R 0.8 &> results/reclin-0.8.txt
/usr/bin/time -v Rscript reclin.R 0.9 &> results/reclin-0.9.txt
/usr/bin/time -v Rscript reclin.R 1.0 &> results/reclin-1.0.txt

echo "fastlink"
/usr/bin/time -v Rscript fastlink.R 0.1 &> results/fastlink-0.1.txt
/usr/bin/time -v Rscript fastlink.R 0.2 &> results/fastlink-0.2.txt
/usr/bin/time -v Rscript fastlink.R 0.3 &> results/fastlink-0.3.txt
/usr/bin/time -v Rscript fastlink.R 0.4 &> results/fastlink-0.4.txt
/usr/bin/time -v Rscript fastlink.R 0.5 &> results/fastlink-0.5.txt
/usr/bin/time -v Rscript fastlink.R 0.6 &> results/fastlink-0.6.txt
/usr/bin/time -v Rscript fastlink.R 0.7 &> results/fastlink-0.7.txt
/usr/bin/time -v Rscript fastlink.R 0.8 &> results/fastlink-0.8.txt
/usr/bin/time -v Rscript fastlink.R 0.9 &> results/fastlink-0.9.txt
/usr/bin/time -v Rscript fastlink.R 1.0 &> results/fastlink-1.0.txt

echo "RecordLinkage"
/usr/bin/time -v Rscript RecordLinkage.R 0.1 &> results/RecordLinkage-0.1.txt
/usr/bin/time -v Rscript RecordLinkage.R 0.2 &> results/RecordLinkage-0.2.txt
/usr/bin/time -v Rscript RecordLinkage.R 0.3 &> results/RecordLinkage-0.3.txt
/usr/bin/time -v Rscript RecordLinkage.R 0.4 &> results/RecordLinkage-0.4.txt
/usr/bin/time -v Rscript RecordLinkage.R 0.5 &> results/RecordLinkage-0.5.txt
#/usr/bin/time -v Rscript RecordLinkage.R 0.6 &> results/RecordLinkage-0.6.txt
#/usr/bin/time -v Rscript RecordLinkage.R 0.7 &> results/RecordLinkage-0.7.txt
#/usr/bin/time -v Rscript RecordLinkage.R 0.8 &> results/RecordLinkage-0.8.txt
#/usr/bin/time -v Rscript RecordLinkage.R 0.9 &> results/RecordLinkage-0.9.txt
#/usr/bin/time -v Rscript RecordLinkage.R 1.0 &> results/RecordLinkage-1.0.txt

echo "reclin2_cluster 8"
/usr/bin/time -v Rscript reclin2_cluster.R 0.1 8 &> results/reclin2_cluster8-0.1.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.2 8 &> results/reclin2_cluster8-0.2.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.3 8 &> results/reclin2_cluster8-0.3.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.4 8 &> results/reclin2_cluster8-0.4.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.5 8 &> results/reclin2_cluster8-0.5.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.6 8 &> results/reclin2_cluster8-0.6.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.7 8 &> results/reclin2_cluster8-0.7.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.8 8 &> results/reclin2_cluster8-0.8.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.9 8 &> results/reclin2_cluster8-0.9.txt
/usr/bin/time -v Rscript reclin2_cluster.R 1.0 8 &> results/reclin2_cluster8-1.0.txt

echo "reclin2_cluster 16"
/usr/bin/time -v Rscript reclin2_cluster.R 0.1 16 &> results/reclin2_cluster16-0.1.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.2 16 &> results/reclin2_cluster16-0.2.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.3 16 &> results/reclin2_cluster16-0.3.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.4 16 &> results/reclin2_cluster16-0.4.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.5 16 &> results/reclin2_cluster16-0.5.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.6 16 &> results/reclin2_cluster16-0.6.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.7 16 &> results/reclin2_cluster16-0.7.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.8 16 &> results/reclin2_cluster16-0.8.txt
/usr/bin/time -v Rscript reclin2_cluster.R 0.9 16 &> results/reclin2_cluster16-0.9.txt
/usr/bin/time -v Rscript reclin2_cluster.R 1.0 16 &> results/reclin2_cluster16-1.0.txt

