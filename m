From: Ian Kent <raven@themaw.net>
Subject: Re: Introduction: I am new
Date: Tue, 20 Jan 2004 23:15:21 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0401202312340.3291-100000@raven.themaw.net>
References: <400C5C32.7070504@windriver.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <400C5C32.7070504@windriver.com>
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
To: Jason Brooks <jason.brooks@windriver.com>
Cc: autofs@linux.kernel.org

On Mon, 19 Jan 2004, Jason Brooks wrote:

> Hello,
> 
> Is there a FAQ for this mailing list?
> 
> If not, here are a couple right off the bat:
> 
> 1) Is it in the plans to support a "-hosts" option as found under solaris's automountd?  (or for 
> that matter, did I just miss it and it should be obvious?)

This function is done by using a program mount in 4.0.0 and above. It does 
not do late mounting so all exports from a given host are mounted when 
accessed. See auto.net in the distribution.

> 
> 2) Is this list for developers, or for users?

Both.

> 
> 3) (something's glimmering inside my brain, but not enough to formulate a third question...)

Don't know the answer to that one.

Ian
