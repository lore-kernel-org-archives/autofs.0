From: raven@themaw.net
Subject: Re: [weasel@debian.org: Bug#296238: autofs breaks nis
	auto.master when there is a tab in nsswitch]
Date: Tue, 22 Feb 2005 00:41:41 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502220039110.20458@donald.themaw.net>
References: <20050221112243.GA18164@uio.no>
Mime-Version: 1.0
In-Reply-To: <20050221112243.GA18164@uio.no>
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
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Mon, 21 Feb 2005, Steinar H. Gunderson wrote:

> FYI: Looks like the change done in the init script for 4.1.4beta2 broke this
> again; I'll revert to the 4.1.3 version and upload.

Strange, I just tested it again and I it works fine for me.
What am I missing in this I wonder?

Any more info. would be great.

>
> BTW, there's also multiple people complaining about the new auto.* scripts
> (see the Debian BTS), but I haven't had time to look into it yet.

It would be good if you could check it out.
I'm keen to know what's is broken.

Ian
