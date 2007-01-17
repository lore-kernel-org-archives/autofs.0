From: Gokdeniz Karadag <gokdeniz@cclub.metu.edu.tr>
Subject: Re: autofs-ldap-nfs is slow because of mtab
Date: Wed, 17 Jan 2007 18:01:38 +0200
Message-ID: <45AE4862.6050905@cclub.metu.edu.tr>
References: <45AD5611.3080405@cclub.metu.edu.tr> <m3wt3ma7sg.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <m3wt3ma7sg.fsf@redhat.com>
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
Cc: autofs@linux.kernel.org



jmoyer@redhat.com demis ki::
> ==> Regarding [autofs] autofs-ldap-nfs is slow because of mtab; Gokdeniz Karadag <gokdeniz@cclub.metu.edu.tr> adds:
> 
> gokdeniz> Hello, In my setup there are three automount mount points. They
> gokdeniz> are all ldap maps. The nfs shares are on the same nfs server. nfs
> gokdeniz> client and automount is on a debian system, nfs server is a
> gokdeniz> solaris one.
> 
> gokdeniz> The problem is, trying to mount a nonexisting directory fails
> gokdeniz> immediately with the message, "No such file or directory" in two
> gokdeniz> of the shares. But the third share waits for 10-30 seconds before
> gokdeniz> giving the error. The maps have 1, 9 and 19 items respectively.
> 
> gokdeniz> I have run strace on the different automount processes. The quick
> gokdeniz> ones show a query to ldap server, then a reasonable amount of
> gokdeniz> mtab stats & reads, then they finish. The process for the slow
> gokdeniz> mount point queries ldap, gets mount map, then for about 100000
> gokdeniz> times; opens mtab file, reads contents and then closes it.  the
> gokdeniz> trace file is full of these; open("/etc/mtab", O_RDONLY) = 7
> gokdeniz> fstat64(7, {st_mode=S_IFREG|0644, st_size=1733, ...}) = 0
> gokdeniz> mmap2(NULL, 4096, PROT_READ|PROT_WRITE,
> gokdeniz> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xa7afb000 read(7, "/dev/sda1
> gokdeniz> / ext3 rw,errors=remou"..., 4096) = 1733 close(7)
> 
> 
> gokdeniz> Any pointers to where should I look ?
> 
> Well, first we need to start with a version.  ;)  What version of autofs
> are you running?  Next, you will want to gather a debug log.  My people
> page has instructions on how to do that:
>   http://people.redhat.com/jmoyer
> 
> That *should* make things fairly obvious.  If it doesn't (or even if it
> does), post a follow-up message here.
> 

Hello,

Restarting autofs fixed the problem. I added --debug and restarted autofs. And 
there is no latency now. I removed the --debug and restarted again, still good. 
Version is debian's 4.1.4-13, I'm stating it to provide clue if anyone 
encounters the same problem.

Thanks for your answer.

- Gokdeniz
