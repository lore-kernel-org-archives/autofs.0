From: Tim Hockin <thockin@hockin.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Tue, 6 Jan 2004 14:47:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040106224751.GA8672@hockin.org>
References: <6AB920CC10586340BE1674976E0A991D0C6BE4@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6AB920CC10586340BE1674976E0A991D0C6BE4@slexch2.sugarland.unocal.com>
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Ogden, Aaron A." <aogden@unocal.com>
Cc: thockin@Sun.COM, "H. Peter Anvin" <hpa@zytor.com>, autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@Sun.COM>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Jan 06, 2004 at 04:28:59PM -0600, Ogden, Aaron A. wrote:
> Solaris there is a command called 'automount' that tells the kernel to
> re-read the automount maps, perhaps it resets the autofs subsystem in
> the kernel as well.  If linux autofs had the same capability we might
> not need the daemon, but until then, having the daemon in userland is a
> good thing.

That's more or less exactly what is proposed.
