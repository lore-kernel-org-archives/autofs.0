From: "Anne.Bourgeois" <anne.bourgeois@analog.com>
Subject: Re: Newbie Question
Date: Thu, 12 Aug 2004 14:44:20 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <411BBA84.7030009@analog.com>
References: <411BAE2F.8040309@analog.com>
	<16667.46801.458839.821849@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16667.46801.458839.821849@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org

Jeff,

My apologies.  I should have included more info in my original post.  
Please see my answers below...

Jeff Moyer wrote:

>==> Regarding [autofs] Newbie Question; "Anne.Bourgeois" <anne.bourgeois@analog.com> adds:
>
>anne> I am pretty new to the list, and I have a very basic question.  How
>anne> do I install the kernel patch so that I can install the autofs rpm?
>
>What distribution are you running?  Do you want to patch a kernel from that
>distribution (recommended), or run a vanilla kernel from kernel.org?
>
>  
>
We are currently running RedHat 8.0 with the 2.4.20.20-8smp kernel.  We 
are looking to go to Enterprise 3 in the near future, but are dependent 
on some software vendors, so we are holding back at the moment.  We are 
seeing several autofs issues, which is the reason that I am trying these 
updates.

>anne> When I tried to just install the new autofs rpm, I got a dependency
>anne> error:
>
>anne>         liblber-2.2.so.7 is needed by autofs-4.1.3-13
>anne> libldap-2.2.so.7 is needed by autofs-4.1.3-13
>
>If you're running Fedora, I'd suggest upgrading your current system with
>yum.
>
>  
>
I'd prefer not to change the basic system that I'm running, as I have 
several users on the current system.  Running on a large network, we see 
the automount map caching as a big problem right now.  I am hoping to 
find a way to fix it without too much upgrading, re-kicking of machines, 
etc.

>anne> I already have autofs-4.1.3-9 installed and didn't see any dependency
>anne> errors when I installed that.
>
>Well, there should be no added dependency requirements.  You _could_ try
>doing an rpm -i --force of the autofs package.
>  
>
# rpm -ivh autofs-4.1.3-13.i386.rpm
error: Failed dependencies:
        liblber-2.2.so.7 is needed by autofs-4.1.3-13
        libldap-2.2.so.7 is needed by autofs-4.1.3-13
# rpm -ivh autofs-4.1.3-13.i386.rpm --force
error: Failed dependencies:
        liblber-2.2.so.7 is needed by autofs-4.1.3-13
        libldap-2.2.so.7 is needed by autofs-4.1.3-13
# rpm -ivh autofs-4.1.3-13.i386.rpm --nodeps --force
Preparing...                ########################################### 
[100%]
   1:autofs                 ########################################### 
[100%]

Finally worked when I used the "--nodeps" flag.  Is this OK, though?

>anne> Is there information somewhere that I can go find about installing
>anne> the kernel patch?
>
>Certainly, but let's figure out which kernel you want to build, first.
>
>-Jeff
>
>
>  
>
