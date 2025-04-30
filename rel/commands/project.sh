#!/bin/sh
            cd /united
            echo  | sudo -S tar xfz united.tar.gz
            sudo mv /united/united.tar.gz /united/releases/0.1.0/
            sudo /united/bin/united stop
            sudo /united/bin/united migrate
            sudo /united/bin/united start
            