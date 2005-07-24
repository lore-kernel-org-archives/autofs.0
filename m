From: Ian Kent <raven@themaw.net>
Subject: Re: running program maps as a different user
Date: Sun, 24 Jul 2005 23:56:10 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0507242349030.5392@donald.themaw.net>
References: <20050724151231.GA2094@kaminsky.dyndns.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050724151231.GA2094@kaminsky.dyndns.org>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Moshe Kaminsky <kaminsky@math.huji.ac.il>
Cc: autofs@linux.kernel.org

On Sun, 24 Jul 2005, Moshe Kaminsky wrote:

> Hi,
> 
> I don't know if this is really the place to ask (I also was unable to 
> view the archives). Anyway, my question is this: suppose I'm using the 
> program map type to return the mount argument. Can I know from within 
> this program who is the user that is causing the mounting to take place? 
> Can I ask that the program be run as that user?

Not yet.

The reason this has not been done so far is that the messages from the 
kernel that request actions need to be a predefined length to maintain 
compatability with older versions of autofs. The current message 
structure doesn't have any user information and so this cannot be used 
during the mount. The time that this can change is when the kernel 
protocol version changes, in this case from version 4 to version 5. I'm 
currently working on getting an alpha of autofs version 5. Indeed, I've 
started work on this very issue tonight.

Ian
