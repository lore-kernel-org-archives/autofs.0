From: Ian Kent <raven@themaw.net>
Subject: Re: autofs breakage & fix
Date: Thu, 20 Dec 2007 15:10:59 +0900
Message-ID: <1198131059.3122.12.camel@raven.themaw.net>
References: <alpine.LFD.0.9999.0712181504550.31763@honker.vgersoft.com>
	<x491w9jppnb.fsf@segfault.boston.devel.redhat.com>
	<alpine.LFD.0.9999.0712191216350.28426@honker.vgersoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LFD.0.9999.0712191216350.28426@honker.vgersoft.com>
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
To: Steve Thompson <smt@vgersoft.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-12-19 at 12:17 -0500, Steve Thompson wrote:
> On Tue, 18 Dec 2007, Jeff Moyer wrote:
> 
> > It's not that the new version is less tolerant, it's that the new
> > version actually allows spaces in path names.
> 
> Ah, gotcha. Thanks,

And, while version 5 is mostly tolerant of this for maps, at some point
the map parser will be re-written and probably won't be nearly as
tolerant.

Ian
