From: Ian Kent <raven@themaw.net>
Subject: Re: getting parameters to executable maps
Date: Fri, 09 Jun 2006 18:41:24 +0800
Message-ID: <1149849684.23627.19.camel@raven.themaw.net>
References: <000101c68b42$54bc0b30$ce054c09@almaden.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <000101c68b42$54bc0b30$ce054c09@almaden.ibm.com>
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

On Thu, 2006-06-08 at 14:27 -0700, aptosca wrote:
> I've been looking for a way to get a parameter to an executable being used
> as a map and have so far failed to come up with anything that will work. Has
> this issue ever arisen? As far as I can tell, the exec of the program gets
> nothing except the key being looked up. The program I'd like to have exec'd
> needs just a little bit of context. It could be passed in through arguments
> specified in the calling map, but autofs doesn't, for example, break the
> string up at spaces for the exec call. Alternatively, if there were a way to
> get at the args that were passed in the options string, that would work,
> too, but again, I don't see anyway of making that happen.

Can you give a little more information please.

A simple example of what your program needs and where it comes from
would be good.

Ian
