From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5 duplicate entries
Date: Tue, 14 Aug 2007 17:12:07 +0800
Message-ID: <1187082727.4963.13.camel@raven.themaw.net>
References: <46A747E0.7070202@math.uni-muenster.de>
	<C9AD2899A176C0499022697035E7625A19CC01@houmbx5.anadarko.com>
	<1185529315.3203.61.camel@raven.themaw.net>
	<46A9C4BB.6090208@math.uni-muenster.de>
	<1185549408.3203.64.camel@raven.themaw.net>
	<C9AD2899A176C0499022697035E7625A19CC2B@houmbx5.anadarko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <C9AD2899A176C0499022697035E7625A19CC2B@houmbx5.anadarko.com>
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
To: "Wolfe, Allan" <Allan.Wolfe@anadarko.com>
Cc: autofs@linux.kernel.org, support@math.uni-muenster.de

On Fri, 2007-07-27 at 18:21 -0500, Wolfe, Allan wrote:

Back to this again.

> On Solaris, only the case defined definition appears as the mount.  I
> guess they have programmed around receiving multiple values for an
> attribute and adopts the one if the % sign is used in one of the values.
> Over RHEL3/autofs 4.1.x, there is a mount per "cn" received.  One with
> case sensitivity, one with the delimiters included.  Not elegant, but
> the case sensitive path is preserved between platforms for the benefit
> of the common applications running cross-platform.  Both mounted paths
> are accessible as mounted.
> 

So is it accurate to say that, in this case, the:

cn: Java

provides the case insensitive match for key java and:

cn: %Java

defines case sensitivity constraints for autofs to use when matching the
entry?

Is it possible then to match Java and JaVa by adding an additional cn
of:

cn: %Ja%Va

to the above entry?

Is it possible then, in this scenario, to have distinct LDAP entries for
keys Java and JaVa?

Ian
