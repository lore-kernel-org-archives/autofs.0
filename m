From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [ANNOUNCE] autofs 5.0.1 rc3 release candidate
Date: Wed, 17 Jan 2007 09:08:20 -0500
Message-ID: <x49ejpt7nl7.fsf@segfault.boston.devel.redhat.com>
References: <200701041309.l04D9S9i031351@raven.themaw.net>
	<45AE01A5.9010408@inria.fr>
	<x49k5zl7ort.fsf@segfault.boston.devel.redhat.com>
	<45AE2BF2.5020907@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45AE2BF2.5020907@inria.fr> (Guillaume Rousse's message of "Wed,
	17 Jan 2007 15:00:18 +0100")
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

==> On Wed, 17 Jan 2007 15:00:18 +0100, Guillaume Rousse <Guillaume.Rousse@inria.fr> said:

Guillaume> Also sprach Jeff Moyer:
Guillaume> > ==> On Wed, 17 Jan 2007 11:59:49 +0100, Guillaume Rousse <Guillaume.Rousse@inria.fr> said:
Guillaume> > 
Guillaume> > Guillaume> - autofs-5.0.1-rc3-separate-config-files.patch split configuration in
Guillaume> > Guillaume> two parts, one for the automount daemon, one for the automount init script
Guillaume> > 
Guillaume> > What is the purpose of this?
Guillaume> Well, to mimic standard setup for all other services.

Guillaume> I also think separating vendor-specific parts, such as init scripts,
Guillaume> from upstream parts, such as main daemon configuration, make life easier
Guillaume> for both parts.

Guillaume> It's easier for packagers to provide vendor-specific customisation
Guillaume> without side effects (I'd prefer avoiding to add a
Guillaume> USE_MDV_SPECIFIC_FEATURE_X in autofs configuration). And it avoid
Guillaume> upstream maintainer to provide vendor-targeted switches, such as
Guillaume> --where-do-you-want-the-automount-configuration-to-be-installed, as this
Guillaume>  standard (%sysconfdir).

OK, I'm with you.  Ian, I'm in favor of this change.

-Jeff
