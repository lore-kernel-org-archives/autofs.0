From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with autofs_home map
Date: Fri, 16 Nov 2007 15:45:39 +0900
Message-ID: <1195195539.3131.43.camel@raven.themaw.net>
References: <BAC1D28A5AB852439A6914CA7AB4E63F041EE76F@permls05.wde.woodside.com.au>
	<1195194075.3131.22.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1195194075.3131.22.camel@raven.themaw.net>
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
To: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Cc: autofs@linux.kernel.org

On Fri, 2007-11-16 at 15:21 +0900, Ian Kent wrote:
> That's bad.
> 
> How about having a look at this I put together a while ago for testing.
> Obviously most of this you've already done but will prove to be a good
> check and then there's the gdb instructions as well.

It also looks like you don't have any debuginfo packages installed.
We'll probably need to get some, at the least the autofs-debuginfo.

Ian
