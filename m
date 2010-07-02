From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Executable maps
Date: Fri, 02 Jul 2010 15:02:49 -0700
Message-ID: <4C2E6209.5030506@zytor.com>
References: <AANLkTin8PTdQLShcrAk_cT21pFfwcuatXvMNMQSgYmO3@mail.gmail.com>
	<1276490691.9943.68.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1276490691.9943.68.camel@localhost>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On 06/13/2010 09:44 PM, Ian Kent wrote:
> 
> Don't think that could work.
> There's no way for a program map to enumerate the entire map at initial
> startup and I don't want to add something that allows that because
> program maps are dynamic and that introduces all sorts of difficulties
> for the handling of direct mounts. And there is no way to use a program
> map for a direct mount that has not been mounted (at startup).
> 

Sorry for a *way late* reply.

There isn't a reason why a protocol for a program map to enumerate
itself couldn't be constructed, probably invoking the program map
without an argument, and receiving an enumeration on stdout; either
null- or LF-separated.

Obviously not all program maps will be capable of being enumerated, but
that's true for any map set.

	-hpa
