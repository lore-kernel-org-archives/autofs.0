From: Chris Stromsoe <cbs@cts.ucla.edu>
Subject: Re: bind mounting into a generated multi-level directory
 structure
Date: Sat, 16 Feb 2008 23:51:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0802162338050.10892@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0802090220120.18112@potato.cts.ucla.edu>
	<47AF07BF.2040405@bononline.nl> <1203028372.8007.54.camel@localhost>
	<47B560D4.9010301@bononline.nl>
	<Pine.LNX.4.64.0802151326180.27197@potato.cts.ucla.edu>
	<47B6B137.3000205@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47B6B137.3000205@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

On Sat, 16 Feb 2008, Stef Bon wrote:
> Chris Stromsoe wrote:
> 
>> My eventual solution was to use multi-mount to bind mount a shared 
>> directory with libraries and other common data to a "simple" generated 
>> path as a container, and then bind mount the hashed directory inside of 
>> that volume.  I'm using the container volume as a chroot environment to 
>> run untrusted code (php) on a web server, and wanted to minimize 
>> exposure to the rest of the machine as much as possible.
> 
> Ok, it's more clear to me now. I'm wondering, isn't it possible to 
> create a custom "chroot" command, which will of course do the chroot, 
> but also do the necessary binds.

Probably.  But I have over 35k virtual hosts.  I need to have the mounts 
expire after some period of non-use.  Having the chroot process handle the 
binds means that I would need to have some other process sitting around to 
unmount everything after a period of inactivity.  Which might as well be 
autofs at that point.

> I've been working on a login shell (chroot_union) which is the standard 
> shell of a user. When this user logs in (starts a session) a copy of the 
> system is created with unionfs. Then a chroot is done, and a perfect 
> environment where the user can do anything is there. Isn't that 
> possible?

The server is only accessible via ftp and http.  I'm trying to limit the 
environment only to what is necessary to run and nothing more.  If I were 
trying to provide a more complete environment with shell access it might 
make sense to use unionfs, but I'm not doing anything that complex. Autofs 
managing the bind mounts (together with a chroot cgi wrapper to limit 
access) covers everything I need.


-Chris
