From: Victor Danilchenko <danilche@cs.umass.edu>
Subject: Re: Automount 5 LDAP filtering question
Date: Fri, 23 Mar 2007 12:09:05 -0400
Message-ID: <4603FBA1.8020408@cs.umass.edu>
References: <4603ECD7.8080906@cs.umass.edu>
	<Pine.LNX.4.64.0703230836240.18094@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0703230836240.18094@simba.math.ucla.edu>
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

Jim Carter wrote:
> On Fri, 23 Mar 2007, Victor Danilchenko wrote:
> 
>> 	The problem is this. We have individual systems indirectly automounting 
>> each other. As such, it is useful for them to be able to keep both the 
>> automounted and the local mountpoints in the same tree, for performance 
>> reasons (rather than mount self over NFS from the /exports/myhost 
>> directory into the /nfs/myhost directory, for example). With automount 
> 
> Which operating system is this?  We're running Linux (with autofs-4), and 
> autofs is smart enough to recognize and do a bind mount of local 
> filesystems, so there is no overhead.

	Interesting. I didn't know that. I am sure it's the same way on Fedora 
and RHEL. I hope someone will offer a way to customize the LDAP filter, 
but if it's not possible, we will go with your idea, thanks.

	Thanks a bunch.

> We don't do anything special; 
> however, the local filesystems are in one place (/h[1-9], /m[1-9]) while 
> the automounted references are elsewhere (/net/$HOSTNAME).   Here's an
> excerpt from /etc/mtab on a typical host, Sunset:
> 
> /dev/sdb2 /m1 ext3 rw,acl,user_xattr,quota 0 0
> automount(pid4220) /net autofs rw,fd=4,pgrp=4220,minproto=2,maxproto=4 0 0
> automount(pid4094) /net/sunset autofs rw,fd=4,pgrp=4220...
> /m1 /net/sunset/m1 none rw,bind 0 0                  <== Bind mount here
> automount(pid21051) /net/julia autofs rw,fd=4,pgrp=4220...
> julia:/h1 /net/julia/h1 nfs rw,,addr=128.97.4.5...   <== NFS mount here
> 
> So at least on Linux you don't need to exclude local filesystems from the 
> automount map.  I believe Solaris also has this situation covered but I 
> can't remember just what it does. 
> 
> James F. Carter          Voice 310 825 2897    FAX 310 206 6673
> UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
> Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)


-- 
|  Victor  Danilchenko  + Unix: Your gun, Your bullet,        |
| danilche@cs.umass.edu |       Your foot, Your choice.       |
|   CSCF   |   5-4231   | MS:   Same as Unix, BUT: No choice, |
+-----------------------+       and We Aim Higher.            |
