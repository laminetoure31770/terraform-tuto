#!/bin/bash
echo "Installation started at $(date)" >> install.log
npm run dev >> install.log 2>&1
