From: raven@themaw.net
Subject: Re: backfstype patch.
Date: Wed, 30 Jun 2004 22:00:41 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406302153150.1811@donald.themaw.net>
References: <40E1CCC3.1010809@deragon.biz>
	<16610.49006.880121.543138@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16610.49006.880121.543138@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Wed, 30 Jun 2004, Jeff Moyer wrote:

> >+		if (!strcmp(curfstype, "cachefs")) {
> >+			/* cachefs not supported for Linux.  We do not even try because when
> >+			   we try, mount will complain about the module being absent.  This is
> >+			   not desired because if backfstype parameter is provided and works,
> >+			   we sure do not want any error messages reported to syslog. */
> >+			debug("cachefs not implemented under Linux and thus ignored.");
> >+			continue;
> >+		}
> >+#endif
> 
> Don't need the ifdef.  Also, try to keep w/in 80 columns, please.

We know it's hard to keep within 80 cols. I constantly try to rearrange 
code to try and achieve this.

> >+		if(!rv)
> >+		{
> >+			break;
> >+		}
> 
> Keep to coding style:  { on same line as if.

The document in the kernel source is an excellent guide to what to try to 
achieve coding standards.

<kernel source dir>/Documentation/CodingStyle

Ian
