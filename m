From: Frank Thommen <frank.thommen@embl-heidelberg.de>
Subject: Using wildcards in multi-mount maps
Date: Sun, 31 May 2015 20:05:45 +0200
Message-ID: <556B4D79.6030006@embl-heidelberg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@vger.kernel.org

Hi,

are wildcards within multi-mount maps supposed to work?

I have the following entry in our maps:

/etc/auto.master (local):
    /mymount yp:mymap --ghost


Indirect NIS map for /mymount:
    $ ypmatch webapps mymap
    /*         -timeo=30                   server:/local/exports/&
    $


On the NIS server the map looks like this:
    webapps \
       /*         -timeo=30                   server:/local/exports/&


However on the client it looks like:

    $ ls /mymount/webapps
    *
    $ ls /mymount/webapps/user
    ls: /mymount/webapps/user: No such file or directory
    $

(/local/exports/user /is/ exported to this client from server)

This is on CentOS 5 with autofs 5.0.1.

Should that work or do I have to solve this mount config in an other way?

Frank

