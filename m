From: Ian Kent <raven@themaw.net>
Subject: Re: unacceptable bug in autofs kernel module
Date: Thu, 30 Dec 2004 08:47:17 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0412300842040.29368@wombat.indigo.net.au>
References: <41D1106C.9070706@intraperson.com>
	<Pine.LNX.4.58.0412290843030.31988@wombat.indigo.net.au>
	<41D21C1E.8040407@intraperson.com>
	<Pine.LNX.4.58.0412291418160.8463@wombat.indigo.net.au>
	<41D28271.601@intraperson.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <41D28271.601@intraperson.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ramana <ramana@intraperson.com>
Cc: autofs@linux.kernel.org

On Wed, 29 Dec 2004, ramana wrote:

> autofs 3 with Fdora core 1 but I suspect even autofs4 also will behave 
> similarly as code does not look different with ENOENT replies.

autofs 3 is not being developed any more.

If you are testing you should use the latest autofs4. This can be done by 
using 2.6.10 or applying the appropriate patch.

If want to try this out let me know and I will post the latest patches I 
have to kernel.org now. 

Ian
