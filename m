From: raven@themaw.net
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta2 release
Date: Tue, 15 Feb 2005 23:21:47 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502152316310.8319@donald.themaw.net>
References: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>

On Mon, 14 Feb 2005 raven@themaw.net wrote:

>
> There are still a few problems that I'm aware of such as:

And a couple I've just found on scribled notes.

- At some point I found nis maps getting called program maps
    This may have been fixed. Can someone check please.
    It may have been when a file map of the same name is
    present in the map directory.

- I think there is a bug handling submount map entries where
    their map type is not specified. Anyone care to investigate
    and get back with findings please.

Ian
