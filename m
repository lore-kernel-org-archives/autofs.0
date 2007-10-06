From: Ian Kent <raven@themaw.net>
Subject: Re: ENOENT on first reference to an automounted file
Date: Sat, 06 Oct 2007 12:48:45 +0800
Message-ID: <1191646125.3060.7.camel@raven.themaw.net>
References: <4706A926.8090503@everyzing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4706A926.8090503@everyzing.com>
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
To: Dan Halbert <halbert@everyzing.com>
Cc: autofs@linux.kernel.org

On Fri, 2007-10-05 at 17:14 -0400, Dan Halbert wrote:
> I have what looks like an automount race condition, and am very puzzled. 
> Any suggestions would be appreciated.
> 
> The first time I reference an automounted file, it is not there 
> (ENOENT). On the second and later try, the file is there. For instance:
> 
>      $ cat /net/fileserver/fs/somefile
>      cat: /net/fileserver/fs/somefile: No such file or directory
>      $ cat /net/fileserver/fs/somefile
>      Contents of somefile.
> 
> I watched the log on fileserver, and the automount request is logged 
> seemingly immediately after the first "cat" prints its error.
> 
> This causes havoc with our applications, which expect files to be there 
> the first time they look for them.
> 
> I can repeat the problem after umounting the fileystem.
> 
> I see this problem on a CentOS 4.x system running their standard 
> autofs-4.1.3-199.3. I do NOT see it on CentOS 5.x, using 
> autofs-5.0.1-0.rc2.43.0.2. Instead I see a slight pause before "cat" 
> prints the contents of the file, presumably as the automount completes. 
> Both the CentOS4 and CentOS5 systems are completely up-to-date.
> 
> I also only see this problem with our Linux NFS servers (FC5 and FC6), 
> but not with a non-Fedora NAS server we have.
> 
> So I am not sure this is an automount problem, per se. Perhaps it's some 
> kind of NFS version problem?
> 
> The automount options include --ghost. At first I thought it might be 
> due to --ghost, because the very first time I reference the file, say 
> after a reboot or restarting autofs, I don't get an ENOENT. The first 
> time, the mountpoint dir does not yet exist. But removing --ghost from 
> the automount options does not seem to fix it.

We've seen this from time to time for various reasons but to be honest I
have trouble remembering so we'll need to check through a debug log.

Jeff may recall this?

Also, you don't mention the kernel versions?

> 
> Gory details about the automount maps are below.
> 
> Thanks for any help,
> Dan Halbert
> 
> ---------------
> More details:
> 
> Our automount maps are stored in ldap. The entry in auto.master for 
> fileserver (for cn=/net/fileserver) is:
> 
>      ldap:ou=auto.fileserver,ou=autofs,dc=example,dc=com --timeout=86400 
> --ghost -o 
> rw,hard,async,noatime,intr,retrans=4,timeo=100,rsize=8192,wsize=8192
> 
> 
> The auto.fileserver is (for cn=*):
> 
>      fileserver.example.com:/export/&

We really must have a debug log, include everything and give some
indication of when the problem occurred. See
http://people.redhat.com/jmoyer for info.

Ian
