From: Michael Loftis <mloftis@wgops.com>
Subject: AutoFS Race Conditions?  Negative Cache?
Date: Tue, 27 Jan 2009 13:04:51 -0700
Message-ID: <F76FAA9B4E7600AAC1FFA15B@ZOP-MACTEL.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

First, I'm sorry if you guys have answered any of this before but since 
there's no public archives (the link on the kernel.org mailman interface 
gets me an apache permission denied error) I'm not able to search them.

Debian 4.0, 2.6.18-6-686 (2.6.18.dfsg.1-23etch1) kernel, autofs 4.1.4-13

IS there any negative cache in AutoFS?  I ask because I appear to be seeing 
repetitive calls to mount things that had already failed.  This is using a 
wildcard map (full deployment, if we can make the automounter work at all 
won't be using a wildcard map).

I keep seeing multiple mounts for the same place, AutoFS appears to race 
itself a lot under high loads.

Is it expected behavior that autofs gets called for EVERY miss under the 
autofs tree?  I would think not, but I can't figure out (excepting maybe 
the race conditions) how a map could cause multiple mount entries except 
because of race conditions.

for ex (actual domain name changed to protect bystanders):  (in 
/proc/mounts)
nfs0:/www/vhosts/l /d1/l/luserdomain.org/logs nfs 
rw,vers=3,rsize=8192,wsize=8192,hard,intr,proto=udp,timeo=11,retrans=2,sec=sys,addr=nfs0 
0 0
/dev/hda3 /d1/l/luserdomain.org/logs/.renv ext3 rw,noatime,data=ordered 0 0


== auto.master ==
/d1/0 /etc/auto.jail -strict -DH=0
/d1/1 /etc/auto.jail -strict -DH=1
...
/d1/z /etc/auto.jail -strict -DH=z

== auto.jail ==
*	/	:/www/vhosts/${H}/& /.renv :/opt/jail


so how does that possibly end up with mounts like I'd shown above?  I was 
under the impression that autofs4 would only ever call automounter with a 
single key...for right now the source of the mounts is an nfs tree, there 
are symlinks to other NFS mounts.  the bind mount mechanism works for now. 
The reason I'm deploying this way and not with a static map is our 
management software does not yet have the bits to modify a (LDAP) map, but 
if it won't work for this proof of concept, I'm not sure it'll work at all.

Any help/guidance/wisdom/etc would be appreciated.

-- 
"Genius might be described as a supreme capacity for getting its possessors
into trouble of all kinds."
-- Samuel Butler
