From: Ian Kent <raven@themaw.net>
Subject: Re: Forward looking standards
Date: Wed, 28 Jan 2009 17:58:46 +0900
Message-ID: <1233133126.3005.41.camel@zeus.themaw.net>
References: <497F76CD.7040505@disneyanimation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <497F76CD.7040505@disneyanimation.com>
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
To: Jay.Hilliard@disneyanimation.com
Cc: autofs@linux.kernel.org

On Tue, 2009-01-27 at 13:04 -0800, Jay Hilliard wrote:
> Hi,
> 
> I'm trying to sort out autofs on various platforms and would like to know which direction is looking standard for the 
> future.
> 
> auto.master or auto_master?  How about for Solaris and OS-X.  Which do you recommend I use in LDAP for most cross 
> platform compatibility?

First, I'm going to assume your thinking autofs version 5 (and a fairly
recent version at that) on Linux and that you want interoperability with
the System V autofs implementation available on Solaris, OpenSolaris and
OS-X. Version 5 of Linux autofs seeks to be feature compatible with
these and if you find issues you should report them.

On Solaris auto_master is the default, I believe this was done due to a
clash with the "." in names when NIS+ was used for map storage. NIS+ has
never been widely used so there's no real reason for us to change to
auto_master. In any case the default master map name can be set in the
autofs configuration.

AFAICT the rfc2307bis schema is the default on Solaris so it may be best
to use that schema. Linux autofs will check for the commonly used schema
and detect maps stored using these so you should be fine using any of
these common ones, at least as far as Linux is concerned. Namely, the
NIS, rfc2307 and rfc2307bis schema.

Ian
