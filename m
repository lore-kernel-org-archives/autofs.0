From: Timo Felbinger <timo.felbinger@physik.uni-potsdam.de>
Subject: Re: Autofs LDAP info
Date: Fri, 30 Sep 2005 17:57:01 +0200
Message-ID: <20050930155701.GR6460@uranos.quantum.physik.uni-potsdam.de>
References: <01C21895FD36D7419A4777E29FED91B90151DA84@houmbx19.anadarko.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <01C21895FD36D7419A4777E29FED91B90151DA84@houmbx19.anadarko.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Fri, Sep 30, 2005 at 08:39:38AM -0500, Wolfe, Allan wrote:
> 
> 
> I have a couple of broader questions along this line that I've not been
> able to discern/decipher out of the information to implement LDAP with
> autofs.  
> 
> (1) How does one utilize ldaps. All the notes I've seen has been
> insecure transport.

You were not only top-posting, but quoted my entire previous message
without reading it? ;-)

> (2) Why doesn't autofs (or maybe it does and it doesn't make sense)
> utilize NSS?

Not sure what exactly you mean, but maybe that's because functions
to support automount map lookup have not (yet) been implented into
glibc? (and neither are such functions mentioned in section 5.2 of
rfc2307, afaik)


Regards,

Timo Felbinger


-- 
Timo Felbinger                  <Timo.Felbinger@physik.uni-potsdam.de>
Quantum Physics Group           http://www.quantum.physik.uni-potsdam.de
Institut fuer Physik            Tel: +49 331 977 1793      Fax: -1767
Universitaet Potsdam, Germany   PGP key-id: E92567B2
