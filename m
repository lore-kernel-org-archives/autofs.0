From: peter@devries.tv
Subject: Re: Simple BINDS over SSL/TLS
Date: Wed, 2 May 2007 11:33:10 -0400
Message-ID: <20070502153310.GF9348@cartman.devries.tv>
References: <20070502151939.GD9348@cartman.devries.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070502151939.GD9348@cartman.devries.tv>
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
To: autofs@linux.kernel.org

On Wed, May 02, 2007 at 11:19:39AM -0400, peter@devries.tv wrote:
> I was wondering if it is possible for autofs to do simple binds over
> TLS/SSL rather than having to do them over SASL.

This may not have been clear enough.  I want autofs to authenticate to
the LDAP server as a user but without the use of SASL. 

Thanks,
Peter
