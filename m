From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: [autofs] [RFC] direct mount support re-work for autofs v4
Date: Wed, 23 Feb 2005 11:27:43 -0800 (PST)
Message-ID: <Pine.LNX.4.61.0502231125510.30588@simba.math.ucla.edu>
References: <Pine.LNX.4.61.0502232157130.8193@donald.themaw.net>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.61.0502232157130.8193@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Wed, 23 Feb 2005 raven@themaw.net wrote:
> I'm planning on reworking the direct mount functionality of autofs
> version 4 to add missing functionality.
> 
> The aim here is to outline my chosen implementation and to get input
> from other interested people to help avoid problems and add value.

From non-guru space the plan looks good: limited reworking of procedures, 
and avoiding features that are baroque and likely to be rarely used in 
practice.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
