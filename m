From: Ian Kent <raven@themaw.net>
Subject: Re: Looking for infor on executable map format
Date: Mon, 29 Mar 2004 14:54:41 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403291450290.18783@wombat.indigo.net.au>
References: <200403261040.08085.krienke@uni-koblenz.de>
	<200403290829.43397.krienke@uni-koblenz.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200403290829.43397.krienke@uni-koblenz.de>
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
To: Rainer Krienke <krienke@uni-koblenz.de>
Cc: autofs@linux.kernel.org, Jim Carter <jimc@krienke.org>

On Mon, 29 Mar 2004, Rainer Krienke wrote:

> >
> Where did you find the information that the format should be like a filemap 
> without the key? I searched the manuals but the only information I was able 
> to find, was that an executable map has to echo a "map" to stdout. A map 
> would have been the key, then optinal options as well as the 
> server:/filesystem entry. But exactly this does not work. So you are probably 
> right that one should omit the key but its not documented as far as I can 
> see.

Looking at the auto.net script in the distribution you see immediately it 
receives a single parameter, the key. Using that it is expected to return 
the map entry corresponding to that key. Excecuting auto.net with a 
host name that has exports, for example, shows what the autofs lookup 
module is expecting back.

Ian
