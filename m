From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: multidir keys and wildcards
Date: Sat, 3 Jan 2009 17:07:40 +0000 (UTC)
Message-ID: <gjo60s$bdm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

OK.  I've been going at my desired implementation from several different 
directions and not found anything that works satisfactorily.

I have a number of filesystems that I statically NFS mount from various 
machines across the network here.  I'd like to convert those all to 
autofs mounted filesystems.  Here's what I currently statically mount:

linux:/mnt/data /data nfs4 rw,vers=4,rsize=8192,wsize=8192,namlen=255,hard,nointr,proto=tcp,timeo=600,retrans=2,sec=krb5,clientaddr=10.75.22.1,addr=10.75.22.3 0 0
linux:/mnt/data/photos /data/photos nfs rw,vers=4,rsize=32768,wsize=32768,namlen=255,hard,nointr,proto=tcp,port=0,timeo=600,retrans=2,sec=krb5,clientaddr=10.75.22.1,addr=10.75.22.3 0 0
linux:/mnt/mp3 /mnt/mp3 nfs4 rw,vers=4,rsize=8192,wsize=8192,namlen=255,hard,nointr,proto=tcp,timeo=600,retrans=2,sec=krb5,clientaddr=10.75.22.1,addr=10.75.22.3 0 0
linux:/mnt/data/photos /data/photos nfs4 rw,vers=4,rsize=8192,wsize=8192,namlen=255,hard,nointr,proto=tcp,timeo=600,retrans=2,sec=krb5,clientaddr=10.75.22.1,addr=10.75.22.3 0 0
pvr:/video /video nfs rw,relatime,vers=3,rsize=8192,wsize=8192,hard,nointr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=10.75.22.2 0 0
jenny:/home/jennifer /autohome/jennifer nfs rw,vers=3,rsize=8192,wsize=8192,namlen=255,soft,nointr,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.75.22.4,mountvers=3,mountproto=tcp,addr=10.75.22.4 0 0

Ideally, I'd like to just drop all of my mounts into aufofs, but as I 
understand it mounting something like that /video or /data filesystems 
requires direct maps and with the autofs 4.1.4 that I am using direct 
mounts don't work?  I could not get them to work in any case with such a 
construct:

--- auto.master ---
/-		/etc/auto.global

--- auto.global ---
/video		pvr:/video

reloading autofs (/etc/init.d/autofs reload) seemed to completely ignore 
the direct map.

So I decided that a /net map and a bunch of symlinks (even though having 
to go to all of the machines and create symlinks will be a pain) might be 
a better way to go.

On Ubuntu, they use a program map for /etc/auto.net which basically 
mounts everything exported by the "key" given to the program.  This is 
pretty ugly... mounting every exported filesystem when access to only one 
is needed.

So I then tried to use wildcards in an effort to just mount the single 
filesystem needed under /net.  That seemed to be a no go with the 
following configuration:

--- auto.master ---
/net		/etc/auto.net

--- auto.net ---
*	-fstype=autofs,-Dhost=&		file:/etc/auto.netsub

--- auto.netsub ---
*	${host}:/&

What seemed to have happened there was that when the key was being 
truncated to the first / on any access.  For example, when I tried to 
access /net/linux/mnt/data, autofs tried to mount linux:/mnt.

So, what is the best (or any) way to get working what I want to do, 
putting aside the ugly auto.net program map that mounts every exported 
filesystem on every access to just any filesystem on the server?

Thanx in advance for any ideas you might have.

b.
