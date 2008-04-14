From: Simon Gao <gao@schrodinger.com>
Subject: Re: [Fwd: Fwd:  autofs-5.0.1-0.rc2.55.el5.3 core dump]
Date: Mon, 14 Apr 2008 12:55:46 -0700
Message-ID: <4803B6C2.5060004@schrodinger.com>
References: <47FFB131.5070603@saic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47FFB131.5070603@saic.com>
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

We are also using autofs with LDAP. 

Simon

Robert Kuropkat wrote:
>
> I am also have this problem on FC6 with:
>
> Name   : autofs
> Arch   : i386
> Epoch  : 1
> Version: 5.0.1
> Release: 0.rc3.33
>
> I **believe** the core dumps started after I updated to this version 
> but can't be sure about that.  I also can supply a core dump if you 
> post where to send it.
>
> Additionally, I am using autofs in conjunction with LDAP.
>
> Robert Kuropkat
>
>
>
> ------------------------------------------------------------------------
>
> Subject:
> Fwd: [autofs] autofs-5.0.1-0.rc2.55.el5.3 core dump
> From:
> "Peter DeVries" <peter@devries.tv>
> Date:
> Fri, 11 Apr 2008 14:25:58 -0400
> To:
> "Robert Kuropkat" <rkuropkat@objectsciences.com>
>
> To:
> "Robert Kuropkat" <rkuropkat@objectsciences.com>
>
>
> If your were monitoring this list you would see these things
>
> ---------- Forwarded message ----------
> From: *Simon Gao* <gao@schrodinger.com <mailto:gao@schrodinger.com>>
> Date: Fri, Apr 11, 2008 at 12:08 PM
> Subject: [autofs] autofs-5.0.1-0.rc2.55.el5.3 core dump
> To: autofs@linux.kernel.org <mailto:autofs@linux.kernel.org>
>
>
> Hi,
>
> We have many RHEL 5.1 desktops running 2.6.18-53.1.14 X86_64. Many of
> them have core dump files related to autofs. The autofs package is
> autofs-5.0.1-0.rc2.55.el5.3.
>
> # strings core.2594 | head
> @UUUU
> @xUUU
> PxUUU
> QqUU
> CORE
> P*fqUU
> dgqUU
> CORE
> automount
> automount -DOSNAME=rhel -DOSREL=5
>
> # strings core.3666 | head
> @UUUU
>  xUUU
> @xUUU
> BWUU
> CORE
> 6xUUU
> VWUU
> XWUU
> CORE
> automount
>
> What caused autofs to core dump? Is there a fix by upgrading to newer
> version?
>
> Simon
>
