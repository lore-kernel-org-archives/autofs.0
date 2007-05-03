From: Ian Kent <raven@themaw.net>
Subject: Re: Simple BINDS over SSL/TLS
Date: Thu, 03 May 2007 08:47:36 +0800
Message-ID: <1178153256.3389.0.camel@raven.themaw.net>
References: <20070502151939.GD9348@cartman.devries.tv>
	<20070502153310.GF9348@cartman.devries.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070502153310.GF9348@cartman.devries.tv>
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
To: peter@devries.tv
Cc: autofs@linux.kernel.org

On Wed, 2007-05-02 at 11:33 -0400, peter@devries.tv wrote:
> On Wed, May 02, 2007 at 11:19:39AM -0400, peter@devries.tv wrote:
> > I was wondering if it is possible for autofs to do simple binds over
> > TLS/SSL rather than having to do them over SASL.
> 
> This may not have been clear enough.  I want autofs to authenticate to
> the LDAP server as a user but without the use of SASL. 

Why don't you want to use SASL?

Ian
