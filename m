From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Problem with autofs 3.1.7 -> 4.1.0-beta2
Date: Sun, 07 Dec 2003 01:14:54 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FD2EF8E.6060309@zytor.com>
References: <Pine.LNX.4.44.0312071347540.2974-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312071347540.2974-100000@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> 
> This looks like a NIS map. Shouldn't the / be a * in this case and 
> shouldn't the wildcard map entry come last. I thouht that the defined 
> behaviour of the wildcard map entry was that once it is encountered map 
> processing stops.
> 

Nope... especially not for non-file maps where there really is no such 
thing as "order"...

	-hpa
