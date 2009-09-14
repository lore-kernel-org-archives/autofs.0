From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: Autofs Negative cache
Date: Mon, 14 Sep 2009 11:45:46 +0200
Message-ID: <4AAE10CA.7050701@s3group.cz>
References: <4AADEE87.3040609@s3group.cz> <4AAE06D7.3090703@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4AAE06D7.3090703@themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>


> You'll need to be a bit more specific about what is wrong.
>   
Ok, my fault - I thought autofs would say something like "negative cache 
hit" if the key is found in the negative cache,
After more detailed log inspection I could see that the actual mount 
requests are suppressed by the negative caching.
Sorry for the noise....

Ondrej
