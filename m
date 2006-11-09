From: Ian Kent <raven@themaw.net>
Subject: Re: Problem patching kernel in Rhel-4
Date: Fri, 10 Nov 2006 02:12:41 +0800
Message-ID: <1163095961.7831.32.camel@localhost>
References: <455360FD.50205@onsemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <455360FD.50205@onsemi.com>
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
To: Dana Wellen <dana.wellen@onsemi.com>
Cc: autofs@linux.kernel.org

On Thu, 2006-11-09 at 12:10 -0500, Dana Wellen wrote:
> Hello,
> 
>   I am really glad to see that autofs is finally being updated to one 
> that works in a multi-OS environment.  Autofs
> has long been a weak link into the standard Unix environment and this 
> version fixes many of the issues I have had
> with v4 and getting the company to switch to Linux because Linux wasn't 
> plug and play with the Solaris automounter.

Bold, trying to patch an already heavily patched kernel.

> 
>   I am getting a error patching the kernel in Rhel-4.
> 
> The kernel being used is 2.6.9-5.ELsmp, I have installed the 
> corresponding source rpm and unpacked the kernel.
> 
> A transcript of the error is:
> 
> patching file fs/namei.c
> Hunk #4 FAILED at 635.
> Hunk #5 succeeded at 752 (offset 6 lines).
> 1 out of 6 hunks FAILED -- saving rejects to file fs/namei.c.rej
> 
> All of the other files used in the patch are patched correctly.  The 
> namei.c file is the only one
> that doesn't patch. 

I'm aware of this.

But I think there may be a couple of other problems with the patches in
the tarball (but mostly for older kernels, I can't remember the
versions).

I have a patch set that should work for a RHEL4 kernel but I strongly
recommend you update to the latest distributed kernel before testing
(something like 2.6.9-42.EL I think).

The patch set should be ok but hasn't seen much testing yet.
If you want to try the patches I'll put them on kernel.org.
It will take a little while.

What version of autofs 5 will you be using for your testing?

snip ..

> 
>  Also, I couldn't find any information on what the flock patches are for 
> in the documentation.

Just use the patches as a reference to check that mount(8):fstab.c (I
think) has the close(2) call moved out of the loop. The RedHat patch to
resolve this is more sophisticated than the one you see in the tar.

You should be ok with RHEL4, but if your packages are as old as the
kernel perhaps you should update util-linux also.

> 
>   I have been able to build the kernel and autofs using Suse 10.1 and 
> Sled 10 but not Rhel-4.

Sorry, I think you will need updated patches, but you may be ok for most
things. I'm trying to get around to doing this.

Ian
