From: Ian Kent <raven@themaw.net>
Subject: Re: automount won't start - just hangs
Date: Tue, 01 Jan 2008 20:49:57 +0900
Message-ID: <1199188197.3246.1.camel@raven.themaw.net>
References: <flbove$pg9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <flbove$pg9$1@ger.gmane.org>
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
To: Jim Duda <jim@duda.tzo.com>
Cc: autofs@linux.kernel.org

On Mon, 2007-12-31 at 17:03 -0500, Jim Duda wrote:
> I'm attempting to use autofs on some diskless machines which operate 
> using an NFS mounted root file system.  I have three different computers 
> which share the same root file system (with unique /tmp and /var 
> directories) and the same 2.6.22 kernel.
> 
> I want to use autofs for removable USB memory sticks.
> 
> On one machine, I can use autofs just fine.  Autofs mounts and unmounts 
> the usb sticks as I expect it to.  Works nice.
> 
> However, on the other two machines, I cannot get automount to start.  It 
> simply hangs upon startup, I cannot ^C to exit or anything.  I have to 
> kill -9 the process.
> 
> I cannot figure out what automount is looking for, and not getting, 
> which would cause it to hang.  I've attempted to use gdb to help me find 
> the problem, but I haven't had much luck.  (I've downloaded the most 
> recent 5.0.2 tar bar and build automount with -g to debug.

Did you apply any of the patches for 5.0.2?

> 
> I'm hoping someone might shed some light on how best to debug this issue.

Have a look at http://people.redhat.com/jmoyer for what to collect and
post here.

Ian
