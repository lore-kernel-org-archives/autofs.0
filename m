From: Ian Kent <raven@themaw.net>
Subject: Re: Transient chdir() failures: cd initially fails,
	where	ls works
Date: Fri, 25 Jan 2008 22:20:42 +0900
Message-ID: <1201267242.3040.64.camel@raven.themaw.net>
References: <920746F6DF728345915EF4D6DA610D0F04710E16@MAILSJ2.global.cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <920746F6DF728345915EF4D6DA610D0F04710E16@MAILSJ2.global.cadence.com>
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
To: Jim Dennis <jdennis@cadence.com>
Cc: autofs@linux.kernel.org


On Thu, 2008-01-24 at 15:37 -0800, Jim Dennis wrote:
>  
>  This is on a RHEL5.1 (x86_64) system using autofs-5.0.1-0.rc2.55 with
>  LDAP driven autofs maps.  It's running under the 2.6.18-53.el5xen
> kernel
>  (in Dom0).  (I see the same behavior from a system running on the 
>  2.6.18-53.el5 (non-Xen) kernel.

Update your kernel to start with.
Ian
