From: raven@themaw.net
Subject: Re: [Feature request] foreground daemon process
Date: Thu, 3 Jun 2004 22:49:39 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406032245580.8111@donald.themaw.net>
References: <20040603171328.1e9b8030@blade.matza.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040603171328.1e9b8030@blade.matza.org>
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
To: Manolis Tzanidakis <mtzanidakis@freemail.gr>
Cc: autofs@linux.kernel.org

On Thu, 3 Jun 2004, Manolis Tzanidakis wrote:

> Hello all,
> I'm using runit (djb's daemontools-alike init w/ service supervision)
> instead of sysvinit as process 1 and I' d like to run the automount
> daemon supervised with it. Could you pls add an option or something in
> automount to make it stay in the foreground ?
> It'd be useful to others for debugging etc. IMO.

That has been asked for a couple of times now.
Have to think about the implications.

What about the fact that it spawns other processes?
I'd have to reimplement the verbose/debug/info output code as well.

There are a number of things that are higher on the priority list though.

Ian
