From: Stef Bon <stef@bononline.nl>
Subject: Re: bind mounting into a generated multi-level directory
 structure
Date: Sat, 16 Feb 2008 10:47:35 +0100
Message-ID: <47B6B137.3000205@bononline.nl>
References: <Pine.LNX.4.64.0802090220120.18112@potato.cts.ucla.edu>	<47AF07BF.2040405@bononline.nl>
	<1203028372.8007.54.camel@localhost>	<47B560D4.9010301@bononline.nl>
	<Pine.LNX.4.64.0802151326180.27197@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0802151326180.27197@potato.cts.ucla.edu>
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
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: autofs@linux.kernel.org

Chris Stromsoe wrote:
> My eventual solution was to use multi-mount to bind mount a shared 
> directory with libraries and other common data to a "simple" generated 
> path as a container, and then bind mount the hashed directory inside 
> of that volume.  I'm using the container volume as a chroot 
> environment to run untrusted code (php) on a web server, and wanted to 
> minimize exposure to the rest of the machine as much as possible.
Ok, it's more clear to me now. I'm wondering, isn't it possible to 
create a custom "chroot" command, which will of course do the chroot, 
but also do the necessary binds. I've been working on a login shell 
(chroot_union) which is the standard shell of a user. When this user 
logs in (starts a session) a copy of the system is created with unionfs. 
Then a chroot is done, and a perfect environment where the user can do 
anything is there. Isn't that possible?

Stef Bon
