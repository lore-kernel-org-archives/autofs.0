From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: [RFC] Towards a Modern Autofs
Date: Fri, 9 Jan 2004 12:51:36 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0401091249250.9335@simba.math.ucla.edu>
References: <Pine.LNX.4.33.0401100143590.21972-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0401100143590.21972-100000@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@sun.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 10 Jan 2004, Ian Kent wrote:
> On Thu, 8 Jan 2004, Mike Waychison wrote:
> > This module will have its own new autofs module (hopefully named
> > something other than autofs to avoid confusion/mishaps).  The VFS will

autofs v3 -> autofs.o
autofs v4 -> autofs4.o
May I suggest autofs5.o?  It should still be named "autofs-something",
after all.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
