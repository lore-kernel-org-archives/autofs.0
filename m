From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: broken hesiod check
Date: Wed, 23 Aug 2006 16:46:20 +0200
Message-ID: <44EC6A3C.2010309@inria.fr>
References: <44EC6677.1070609@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44EC6677.1070609@inria.fr>
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

Guillaume Rousse wrote:
> The hesiod check macros breaks configure script by changing LIBS value
> inconditionally, wich is evil.
I forget to precise it had also the unpleasant effect of making all
following checks (sasl, ldap) fails because -lhesiod is systematically
added to the linking attempt.
-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
