From: raven@themaw.net
Subject: Re: [PATCH] replicated mounts overhaul
Date: Mon, 2 May 2005 22:01:20 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0505022157230.9314@donald.themaw.net>
References: <1115040578.3594.9.camel@barsoom.rdu.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1115040578.3594.9.camel@barsoom.rdu.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeffrey Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org

On Mon, 2 May 2005, Jeffrey Layton wrote:

> Here's the latest version of the replicated mounts patch that I've been
> working on. I sent this a couple of weeks ago and got no response.

I've been trying to get my direct mount stuff working.

>
> This version strips out commas around whitespace before parsing the
> line, so it should meet Ian's request for the parser to handle that.
>
> This version should apply to the current version of CVS as of this
> morning. I looked over the changes that have been made to the CVS tree
> since my last pull and I think that my patch replaces the sections of
> code that have seen changes.

I think some of what was in your original was included in a smaller patch 
by Chris Feist.

Once I've got the direct mount stuff, at least basically working, I'll 
return to reviewing your patch and the LDAP patch(s) I have.

Ian
