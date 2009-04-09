From: Ian Kent <raven@themaw.net>
Subject: Re: autofs double mount when key in mapfile is a relative
 path...
Date: Thu, 09 Apr 2009 20:32:05 +0800
Message-ID: <49DDEAC5.50409@themaw.net>
References: <2BA9322EE5F80A4B8E7B40593937D5A301825AE6@defrm203.emea.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <2BA9322EE5F80A4B8E7B40593937D5A301825AE6@defrm203.emea.corp.eds.com>
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
To: "Mazzocchi, Stefano" <stefano.mazzocchi@eds.com>
Cc: autofs@linux.kernel.org, TS-AS-UNIX-ICT@sict.eni.it

Mazzocchi, Stefano wrote:
> 
> Hi there, 
> 
> I hope this is the right place to post a issue we experience with autofs
> on Linux Redhat 4.6.  
> We are using indirect mount to mount different directories from the same
> host at different depth level. 
> Each directory is a separate file system on the file server.  File
> server is a Sun Solaris 8. 
> Here  my auto.master entry: 
> 
> cat auto.master: 
> /data/gqssan1   /etc/auto.gqssan1 --ghost --timeout=60
> 
> I assume that I can specify a relative path name as "key" within my
> mapfile: 

You assumption is wrong.
The key is not a path and is not treated as a path.
If you have any success with this it is purely by chance.

If you need mounts in lower level directories then you need to use a
submount.

> 
>    key
>        For indirect mounts this is the part of the pathname between the
> mount-
>        point  and the path into the filesystem mounted. Usually you can
> think
>        about the key as a subdirectory name below the mountpoint.
> 
> here is my mapfile entry: 
> 
> cat auto.gqssan1
> 
> 1       	-rw,soft,intr   stargeo:/data/gqssan1/1
> ...
> 30       	-rw,soft,intr   stargeo:/data/gqssan1/30

From here

> GEOS/1       -rw,soft,intr   stargeo:/data/gqssan1/GEOS/1
> GEOS/2       -rw,soft,intr   stargeo:/data/gqssan1/GEOS/2
> GEOS/3       -rw,soft,intr   stargeo:/data/gqssan1/GEOS/3
> GEOS/4       -rw,soft,intr   stargeo:/data/gqssan1/GEOS/4

to here, into another map, say auto.another:
1       -rw,soft,intr   stargeo:/data/gqssan1/GEOS/1
2       -rw,soft,intr   stargeo:/data/gqssan1/GEOS/2
3       -rw,soft,intr   stargeo:/data/gqssan1/GEOS/3
4       -rw,soft,intr   stargeo:/data/gqssan1/GEOS/4

and to auto.gqssan1 add:
GOES      -fstype=autofs  auto.another

> 
> At the very beginning everything seems to be fine. After about 10
> minutes time,  I see another mount point 
> with the same name within the very first one: 
> 
> [root@ensv16im gqssan1]# cd /data/gqssan1/GEOS/
> [root@ensv16im GEOS]# ls -tlr
> total 0
> dr-xr-xr-x    6 root     root            0 Apr  8 00:03 GEOS
> dr-xr-xr-x    2 root     root            0 Apr  8 00:03 4
> dr-xr-xr-x    2 root     root            0 Apr  8 00:03 3
> dr-xr-xr-x    2 root     root            0 Apr  8 00:03 2
> dr-xr-xr-x    2 root     root            0 Apr  8 00:03 1
> 
> I cd to both mount points and I see my file system mounte twice. 
> 
> [root@ensv16im GEOS]# df -h
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/vg00/rootvol     7.8G  3.3G  4.2G  44% /
> /dev/sda1              99M   33M   61M  36% /boot
> none                  989M     0  989M   0% /dev/shm
> siful4:/vol/siful4_base/3RD
>                       170G  166G  5.0G  98% /sw/3rd
> /dev/vg01/owdata       72G   33M   69G   1% /data
> stargeo:/data/gqssan1/1
>                       172G  131G   41G  77% /data/gqssan1/GEOS/1
> stargeo:/data/gqssan1/GEOS/1
>                       506G  149G  355G  30% /data/gqssan1/GEOS/GEOS/1
> 
> 
> Am I correctly assuming that the "key" value may be a relative path as
> well as a simple directory? 
> 
> Please help. 
> 
> Best regards, 
> 
> Stefano Mazzocchi 
> tel 02.99964140
> ts-as-unix
> EDS - via Medici del vascello 
> mailto:stefano.mazzocchit@eds.com
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
