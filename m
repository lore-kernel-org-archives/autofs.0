From: Ian Kent <raven@themaw.net>
Subject: Re: autofs options and LDAP
Date: Wed, 14 Jan 2009 10:55:04 +0900
Message-ID: <1231898104.3168.14.camel@zeus.themaw.net>
References: <1231894833.3319.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1231894833.3319.59.camel@localhost.localdomain>
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
To: Brian Kosick <bkosick@mxlogic.com>
Cc: autofs@linux.kernel.org

On Tue, 2009-01-13 at 18:00 -0700, Brian Kosick wrote:
> Hi All,
> 
> I'm trying to add the autofs option --ghost to a 2307bis? autofs.ldif
> schema file.  It seems to have come up at least once back in 2006, but
> after a workaround was suggested and accepted by the original reporter,
> I don't think that anything has ever come of it.
> 
> http://www.mail-archive.com/autofs@linux.kernel.org/msg05449.html
> 
> https://www.redhat.com/archives/fedora-directory-users/2009-January/msg00035.html
> 
> In short I've got it working great except that I want one autofs map to
> use --ghost and one to not use ghost, so the adding ghost to
> the /etc/sysconfig/autofs options won't work for me.
> 
> Can anyone provide information as to the state of this?  I would
> appreciate any help greatly.

What autofs version?

Ian
