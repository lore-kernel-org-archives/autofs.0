From: Dax Kelson <dax@gurulabs.com>
Subject: Re: name spaces good (was: [autofs] [RFC] Towards a Modern Autofs)
Date: Tue, 06 Jan 2004 15:28:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1073428129.2454.35.camel@mentor.gurulabs.com>
References: <3FFB12AD.6010000@sun.com> <3FFB223A.8000606@zytor.com>
	 <20040106215018.GA911@sun.com>  <3FFB316A.6000004@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <3FFB316A.6000004@zytor.com>
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: thockin@Sun.COM, Mike Waychison <Michael.Waychison@Sun.COM>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 2004-01-06 at 15:06, H. Peter Anvin wrote:
> First of all, I'll be blunt: namespaces currently provide zero benefit
> in Linux, and virtually noone uses them.

I strongly disagree.

I find them very useful, and there are lots of problems that are not
cleanly solved any other way. In particular they are very useful in
security hardening, compartmentalization scenarios.

The abysmal state of Linux autofs is something that needs fixing
yesterday.

Dax Kelson
