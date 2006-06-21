From: Ian Kent <raven@themaw.net>
Subject: RE: getting parameters to executable maps
Date: Wed, 21 Jun 2006 23:25:36 +0800
Message-ID: <1150903536.14524.13.camel@raven.themaw.net>
References: <1150901405.14524.3.camel@raven.themaw.net>
	<000101c69544$8a747300$9f5d5900$@org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <000101c69544$8a747300$9f5d5900$@org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: aptosca <aptosca@esseff.org>
Cc: autofs@linux.kernel.org

On Wed, 2006-06-21 at 08:08 -0700, aptosca wrote:
> 	I've been thinking about that but I'm not sure about it.
> 	Mainly because the information flow is from autofs to the program
> and
> 	autofs can't know what environment to set.
> 
> 	Are you perhaps suggesting we define one or so?
> 
> That's what I was thinking of. I kinda thought the command line option would
> be too messy. But adding a variable to the environment (either after the
> fork before the exec or before the fork and retracting it, depending on the
> impact on COW paging stuff?) would seem pretty benign.

Mind you we have code that constructs the argument array for passing to
submounts. Very similar code to the program map.

Maybe that is the way to do it after all.

Ian
