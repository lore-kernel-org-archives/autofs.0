From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Newbie Question
Date: Thu, 12 Aug 2004 14:28:33 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16667.46801.458839.821849@segfault.boston.redhat.com>
References: <411BAE2F.8040309@analog.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <411BAE2F.8040309@analog.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: "Anne.Bourgeois" <anne.bourgeois@analog.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Newbie Question; "Anne.Bourgeois" <anne.bourgeois@analog.com> adds:

anne> I am pretty new to the list, and I have a very basic question.  How
anne> do I install the kernel patch so that I can install the autofs rpm?

What distribution are you running?  Do you want to patch a kernel from that
distribution (recommended), or run a vanilla kernel from kernel.org?

anne> When I tried to just install the new autofs rpm, I got a dependency
anne> error:

anne>         liblber-2.2.so.7 is needed by autofs-4.1.3-13
anne> libldap-2.2.so.7 is needed by autofs-4.1.3-13

If you're running Fedora, I'd suggest upgrading your current system with
yum.

anne> I already have autofs-4.1.3-9 installed and didn't see any dependency
anne> errors when I installed that.

Well, there should be no added dependency requirements.  You _could_ try
doing an rpm -i --force of the autofs package.

anne> Is there information somewhere that I can go find about installing
anne> the kernel patch?

Certainly, but let's figure out which kernel you want to build, first.

-Jeff
