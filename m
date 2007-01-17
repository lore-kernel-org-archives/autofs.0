From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: [ANNOUNCE] autofs 5.0.1 rc3 release candidate
Date: Wed, 17 Jan 2007 15:00:18 +0100
Message-ID: <45AE2BF2.5020907@inria.fr>
References: <200701041309.l04D9S9i031351@raven.themaw.net>	<45AE01A5.9010408@inria.fr>
	<x49k5zl7ort.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49k5zl7ort.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Also sprach Jeff Moyer:
> ==> On Wed, 17 Jan 2007 11:59:49 +0100, Guillaume Rousse <Guillaume.Rousse@inria.fr> said:
> 
> Guillaume> - autofs-5.0.1-rc3-separate-config-files.patch split configuration in
> Guillaume> two parts, one for the automount daemon, one for the automount init script
> 
> What is the purpose of this?
Well, to mimic standard setup for all other services.

I also think separating vendor-specific parts, such as init scripts,
from upstream parts, such as main daemon configuration, make life easier
for both parts.

It's easier for packagers to provide vendor-specific customisation
without side effects (I'd prefer avoiding to add a
USE_MDV_SPECIFIC_FEATURE_X in autofs configuration). And it avoid
upstream maintainer to provide vendor-targeted switches, such as
--where-do-you-want-the-automount-configuration-to-be-installed, as this
 standard (%sysconfdir).
