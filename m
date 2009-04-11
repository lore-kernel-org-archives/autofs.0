From: "Marty Leisner" <leisner@rochester.rr.com>
Subject: automount core's on strdup(NULL)
Date: Sat, 11 Apr 2009 19:45:16 +0000
Message-ID: <200904111945.n3BJjGqU028093@dell2.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-ID: <28090.1239479116.1@dell2.home>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org
Cc: martyleisner@yahoo.com

I just installed opensuse 11.1 -- couldn't get autofs to work...

I scratched my head - its using 5.03 --so I got 5.04 -- also core (but 
I could build it -g).

So I got the head of the git tree....same problem...

(gdb) bt
 #0  0xb7f37743 in strlen () from /lib/libc.so.6
 #1  0xb7f37465 in strdup () from /lib/libc.so.6
 #2  0xb80abaf5 in master_new_mapent (master=0xb80c4368, path=0x0,
     age=1239478044) at master.c:666
 #3  0xb80b18ab in master_parse_entry (buffer=0xb80e0aa0 "/net /etc/auto.net",
     default_timeout=600, logging=0, age=1239478044) at master_parse.y:771
 #4  0xb7eab462 in lookup_read_master (master=0xb80c4368, age=1239478044,
     context=0xb80c5430) at lookup_file.c:469
 #5  0xb809b744 in do_read_master (master=0xb80c4368, type=0xb80c4458 "files",
     age=1239478044) at lookup.c:96
 #6  0xb809b8a9 in read_master_map (master=0xb80c4368, type=0xb80c4458 "files",
     age=1239478044) at lookup.c:135
 #7  0xb809bc80 in lookup_nss_read_master (master=0xb80c4368, age=1239478044)
     at lookup.c:223
 #8  0xb80ac1cb in master_read_master (master=0xb80c4368, age=1239478044,
     readall=0) at master.c:814
 #9  0xb8091e2c in main (argc=0, argv=0xbfcbde40) at automount.c:2094

I ended up doing this:
: leisner@gateway 03:42:23;rcsdiff -u master.c
===================================================================
RCS file: master.c,v
retrieving revision 1.1
diff -u -r1.1 master.c
--- master.c    2009/04/11 19:35:35     1.1
+++ master.c    2009/04/11 19:36:20
@@ -657,6 +657,9 @@
        int status;
        char *tmp;

+       if(!path)
+               return NULL;
+
        entry = malloc(sizeof(struct master_mapent));
        if (!entry)
                return NULL;

I think I ended up with a parse error at the end (not sure that was valid
when I started -- I had
misc  /etc/auto.misc

instead of 
/misc  /etc/auto.misc

marty
