From: raven@themaw.net
Subject: Re: can write on smb resource
Date: Thu, 13 Jan 2005 00:09:05 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501130006160.8414@donald.themaw.net>
References: <20050112165724.45d20f9a@localhost>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050112165724.45d20f9a@localhost>
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
To: abo <abo@brujulatelecom.com>
Cc: autofs@linux.kernel.org

On Wed, 12 Jan 2005, abo wrote:

> hi!
>
> im using an ldap server to mount several smb resources. i can get it
> mounted with no problems except i can't write on it even with rw option.
> i think this is something regarding the fact that files are owned by
> root. i know that autofs always mount things as root, so how can i avoid
> this problem?

This is a known problem without any resolution yet.

You need to specify the credentials in you autofs maps.
autofs doesn't know anything about who is doing the mount and so can't 
even look up credentials if they were stored somewhere.

Maybe someone on the list has a suggestion for working around this.

Ian
