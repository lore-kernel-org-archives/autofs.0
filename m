From: raven@themaw.net
Subject: Re: [PATCH 0/5] rediffed patches
Date: Sun, 13 Feb 2005 20:26:08 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502132017290.2089@donald.themaw.net>
References: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
In-Reply-To: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: autofs@linux.kernel.org

On Fri, 11 Feb 2005, Denis Vlasenko wrote:

> Originally done against 4.1.3. Rediffed against 4.1.4_beta1 now
>
> Please comment /apply

I like em.

I can see you've put a lot of effort into them and first glance looks 
good.

I was going to put out beta2 tonight but now I've received your patches 
I'm going to have to delay a couple of days (it's already late).

The fact that you've broken them down so I can see what's going on and the 
way you've done the logging goes further than what I set out to do when I 
first changed it. It's just what I wanted originally.

However, I must push back on the PATH patch claiming it's a security hole. 
I would feel better about it if we overroad the PATH within the daemon 
with something suitable.

Ian
