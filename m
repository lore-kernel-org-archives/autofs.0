From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [weasel@debian.org: Bug#296238: autofs breaks nis
	auto.master when there is a tab in nsswitch]
Date: Mon, 21 Feb 2005 12:26:15 -0500
Message-ID: <16922.6583.732541.521136@segfault.boston.redhat.com>
References: <20050221112243.GA18164@uio.no>
	<Pine.LNX.4.61.0502220039110.20458@donald.themaw.net>
	<20050221171509.GA31256@uio.no>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050221171509.GA31256@uio.no>
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
Content-Type: text/plain; charset="us-ascii"
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] [weasel@debian.org: Bug#296238: autofs breaks nis auto.master when there is a tab in nsswitch]; "Steinar H. Gunderson" <sgunderson@bigfoot.com> adds:

sgunderson> On Tue, Feb 22, 2005 at 12:41:41AM +0800, raven@themaw.net
sgunderson> wrote:
>> Strange, I just tested it again and I it works fine for me.  What am I
>> missing in this I wonder?

sgunderson> Probably a different version of grep or something? I've had
sgunderson> three separate bug reports on this, so I guess it _is_ indeed
sgunderson> broken. :-)

Actually, what is LC_ALL set to?

Try your grep again after doing this:

export LC_ALL=C

-Jeff
